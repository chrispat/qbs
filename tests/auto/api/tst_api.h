/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing
**
** This file is part of the Qt Build Suite.
**
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company.  For licensing terms and
** conditions see http://www.qt.io/terms-conditions.  For further information
** use the contact form at http://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 or version 3 as published by the Free
** Software Foundation and appearing in the file LICENSE.LGPLv21 and
** LICENSE.LGPLv3 included in the packaging of this file.  Please review the
** following information to ensure the GNU Lesser General Public License
** requirements will be met: https://www.gnu.org/licenses/lgpl.html and
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, The Qt Company gives you certain additional
** rights.  These rights are described in The Qt Company LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
****************************************************************************/

#ifndef QBS_TST_API_H
#define QBS_TST_API_H

#include <QObject>

namespace qbs { class SetupProjectParameters; }

class LogSink;

class TestApi : public QObject
{
    Q_OBJECT

public:
    TestApi();
    ~TestApi();

private slots:
    void initTestCase();

    void buildGraphLocking();
    void buildSingleFile();
#ifdef QBS_ENABLE_PROJECT_FILE_UPDATES
    void changeContent();
#endif
    void commandExtraction();
    void disabledInstallGroup();
    void fileTagsFilterOverride();
    void infiniteLoopBuilding();
    void infiniteLoopBuilding_data();
    void infiniteLoopResolving();
    void installableFiles();
    void isRunnable();
    void listBuildSystemFiles();
    void multiArch();
    void nonexistingProjectPropertyFromProduct();
    void nonexistingProjectPropertyFromCommandLine();
    void projectInvalidation();
    void projectLocking();
    void references();
    void sourceFileInBuildDir();

private:
    qbs::SetupProjectParameters defaultSetupParameters() const;

    LogSink * const m_logSink;
    const QString m_sourceDataDir;
    const QString m_workingDataDir;
};

#endif // Include guard.
