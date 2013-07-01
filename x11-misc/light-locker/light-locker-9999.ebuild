# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools-utils git-2

DESCRIPTION="A simple locker using lightdm"
HOMEPAGE="https://github.com/ochosi/light-locker"
EGIT_REPO_URI="https://github.com/ochosi/light-locker.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="x11-misc/lightdm"
DEPEND="${RDEPEND}"

AUTOTOOLS_AUTORECONF=yes
DOCS=( AUTHORS COPYING COPYING.LIB HACKING MAINTAINERS NEWS README )

src_prepare() {
	NOCONFIGURE=1 ${S}/autogen.sh
}
